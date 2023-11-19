import { getInput, setFailed, summary, debug, info } from '@actions/core'
import { exec } from '@actions/exec'

type Inputs = {
  path: string
  output: string
  base: string
}

function asArg(name: string, value: string): string[] {
  if (value === '') {
    return []
  }
  debug(`${name}: ${value}`)
  return ['--' + name, value]
}

async function build({
  path,
  output,
  base
}: Inputs): Promise<void> {
  const args = [
    ...asArg('base', base),
    ...asArg('output', output),
    path
  ]
  info(`Building...`)
  await exec('npx', ['likec4', 'build', ...args])
}

async function exportPng({
  path,
  output
}: Inputs): Promise<void> {
  const args = [
    ...asArg('output', output),
    path
  ]
  info(`Exporting to PNG...`)
  await exec('npx', ['likec4', 'export', 'png', ...args])
}

/**
 * The main function for the action.
 * @returns {Promise<void>} Resolves when the action is complete.
 */
export async function run(): Promise<void> {
  try {
    const action = getInput('action')
    const exportTo = getInput('export')

    const inputs: Inputs = {
      path: getInput('path'),
      output: getInput('output'),
      base: getInput('base')
    }

    action != '' && debug(`action: ${action}`)
    exportTo != '' && debug(`export: ${exportTo}`)
    debug(`cwd: ${process.cwd()}`)
    debug(`path: ${inputs.path}`)


    if (action === 'export' || (action === '' && exportTo === 'png')) {
      await exportPng(inputs)
      return
    }

    if (action === 'build' || (action === '' && exportTo === '')) {
      await build(inputs)
      return
    }

    setFailed(`invalid input`)
  } catch (error) {
    // Fail the workflow run if an error occurs
    if (error instanceof Error) setFailed(error.message)
  }
}