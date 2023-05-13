// TODO
// - automate `npm publish --access public`
// - replace image links from addons `README.md`
import fs from 'node:fs/promises'
import path from 'node:path'
import ini from 'ini'


const ADDON_SCOPE = '@razcore-rad'
const ADDON_GITHUB_USER = 'GDQuest'
const ADDON_CFG_FILE_NAME = 'plugin.cfg'
const ADDON_PACKAGE_JSON_FILE_NAME = 'package.json'
const ADDON_PACKAGE_JSON_TEMPLATE = {
  name: '',
  version: '',
  description: '',
  main: 'index.js',
  scripts: {
    test: 'echo \'Error: no test specified\' && exit 1'
  },
  repository: {
    type: 'git',
    url: `git+https://github.com/${ADDON_GITHUB_USER}/godot-addons.git`
  },
  keywords: [
    'addon',
    'gdquest',
    'godot',
    'godotengine',
  ],
  author: '',
  license: '',
  bugs: {
  	url: `https://github.com/${ADDON_GITHUB_USER}/godot-addons/issues`
  },
  homepage: '',
}

const ADDONS_DIR = 'addons'

const LICENSE_FILE_NAME = 'LICENSE'

const README_FILE_NAME = 'README.md'
const README_HEADER = [
  '# GDQuest Godot Addons',
  '',
  'This is part of a GDQuest Godot repository containing multiple addons:',
  ''
]

async function main() {
  try {
    const LICENSE = (await fs.readFile(LICENSE_FILE_NAME, { encoding: 'utf8' })).split(/[\r\n]+/).slice(0, 1).join().split(/ +/).slice(0, 1).join()
    const ADDONS_DIRS = await fs.readdir(ADDONS_DIR)

    let readme = README_HEADER
    for (const DIR of ADDONS_DIRS) {
      const ADDON_PATH = path.join(ADDONS_DIR, DIR)
      const ADDON_CFG = ini.parse(await fs.readFile(path.join(ADDON_PATH, ADDON_CFG_FILE_NAME), { encoding: 'utf8' }))
      const ADDON_PACKAGE_JSON = {
        ...ADDON_PACKAGE_JSON_TEMPLATE,
        author: ADDON_CFG.plugin.author,
        description: ADDON_CFG.plugin.description,
        homepage: `https://github.com/${ADDON_GITHUB_USER}/godot-addons/tree/main/${ADDONS_DIR}/${DIR}#readme`,
        license: LICENSE,
        name: `${ADDON_SCOPE}/${DIR}`,
        version: ADDON_CFG.plugin.version,
      }
      await fs.writeFile(path.join(ADDON_PATH, ADDON_PACKAGE_JSON_FILE_NAME), JSON.stringify(ADDON_PACKAGE_JSON))

      readme = [...readme, `- [${ADDON_CFG.plugin.name}](${ADDON_PATH})`]
      await fs.cp(LICENSE_FILE_NAME, path.join(ADDON_PATH, LICENSE_FILE_NAME))
    }
    await fs.writeFile(README_FILE_NAME, readme.join('\n'))
  } catch (err) {
    console.log(err)
  }
}

main()
