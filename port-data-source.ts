import * as sharp from 'sharp'
import * as path from 'path'
import * as qrcode from 'qrcode';

module.exports = {
  base64Icons: async function(tagsList: any) {
    const fetch = (await import('node-fetch')).default

    const results = []
    for (const tags of tagsList) {
      const result = []
      for (const tag of tags) {
        result.push(new Promise(async function(resolve) {
          const data = await fetch(tag.icon).then(res => res.arrayBuffer())
          const ext = path.extname(tag.icon).slice(1)
          const ico = ext === 'ico'
          const resized = ico ? data : await sharp(new Uint8Array(data)).resize(64, 64).webp().toBuffer()
          const base64 = Buffer.from(resized).toString('base64')
          const icon = `data:image/${ico ? 'ico' : 'webp'};base64,${base64}`
          resolve({
            ...tag,
            icon
          })
        }))
      }
      results.push(Promise.all(result))
    }
    return Promise.all(results)
  },
  qrcode: async function() {
    return new Promise(resolve => qrcode.toDataURL('https://jaye.blackarts.tech',  { errorCorrectionLevel: 'H' }, (err, url) => {
      resolve(url)
    }))
  }
}