/*
  *
  * nix-prefetch-url --name arst.crx 'https://clients2.google.com/service/u
redirect&acceptformat=crx2,crx3&prodversion=92&x=id%3Dcjpalhdlnbpafiamejd
allsource%3Dondemand%26uc'

nix-prefetch-url --name ublock-origin.crx 'https://clients2.google.com/service/u
redirect&acceptformat=crx2,crx3&prodversion=1.63.2&x=id%3Dcjpalhdlnbpafiamejd
allsource%3Dondemand%26uc'


nix-prefetch-url --name arst.crx 'https://clients2.google.com/service/uredirect&acceptformat=crx2,crx3&prodversion=92&x=id%3Dcjpalhdlnbpafiamejdnhcphjbkeiagm&allsource%3Dondemand%26uc'


path is '/nix/store/yh1zgrdab3k7c7ad3wa6nx785ckdwp8x-arst.crx'
026l3wq4x7rg9f0dz4xiig25x8b7h0syil1d09hbpfzv0yg5bm4m


https://clients2.google.com/service/update2/crx?response=redirect&prodversion=[PRODVERSION]&acceptformat=crx2,crx3&x=id%3D[EXTENSIONID]%26uc

nix-prefetch-url --name privacy-badger 'https://clients2.google.com/service/update2/crx?response=redirect&prodversion=2025.3.27&acceptformat=crx2,crx3&x=id%3Dpkehgijcmpdhfbdbbnkijodmdjhbjlgp%26uc'
nix-prefetch-url --name cookies-autodelete 'https://clients2.google.com/service/update2/crx?response=redirect&prodversion=3.8.2&acceptformat=crx2,crx3&x=id%3Dfhcgjolkccmbidfldomjliifgaodjagh%26uc'


url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
name = "${id}.crx";

*/
const extensions = [
  {
    name: 'ublock-origin',
    id: 'cjpalhdlnbpafiamejdnhcphjbkeiagm',
    version: '134.0.6998.88'
  },
  {
    name: 'privacy-badger',
    id: 'pkehgijcmpdhfbdbbnkijodmdjhbjlgp',
    version: '134.0.6998.88'
  },
  {
    name: 'cookies-autodelete',
    id: 'fhcgjolkccmbidfldomjliifgaodjagh',
    version: '134.0.6998.88'
  },
  {
    name: '1password',
    id: 'aeblfdkhhhdcdjpifhhbdiojplfjncoa',
    version: '134.0.6998.88'
  },
  {
    name: 'lexical-developer-tools',
    id: 'kgljmdocanfjckcgfpcpdoklodllfdpc',
    version: '134.0.6998.88'
  }
]

console.log('starting...')
for (const ext of extensions) {
  console.log(ext)
  const url = `https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${ext.version}&x=id%3D${ext.id}%26installsource%3Dondemand%26uc`
  const cmd = new Deno.Command('nix-prefetch-url', { args: ['--name', ext.id, url] })
  const { code, stdout, stderr } = await cmd.output()
  console.log(code)
  console.log(new TextDecoder().decode(stdout));
  console.log(new TextDecoder().decode(stderr));
}

