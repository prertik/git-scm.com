const lunr = require('../assets/js/lunr-2.3.9.min.js'),
  fs = require('fs'),
  input = fs.createReadStream('_site/search/search-data.json'),
  buffer = []

process.stderr.write('reading from input\n')
input.resume()
input.setEncoding('utf8')

input.on('data', function (data) {
  buffer.push(data)
})

input.on('end', function () {
  process.stderr.write('concatenating input\n')
  const documents = JSON.parse(buffer.join(''))

  process.stderr.write('building index\n')
  const result = {}
  result.index = lunr(function () {
    this.ref('id');
    this.field('title', { boost: 10 });
    this.field('category');
    this.field('content');

    for (var key in documents) {
      const item = documents[key]

      if (item.url.match(/docs\/.*\//) || item.url.match(/\.(css|json)$/)) continue
      if (item.url.startsWith('/book/') && !item.url.startsWith('/book/en/')) continue

      result[key] = {
	url: item.url,
	title: item.title,
	content: item.content.substring(0, 150)
      }

      this.add({
        'id': key,
        'title': item.title,
        'category': item.category,
        'content': item.content
      });
    }
  })

  process.stderr.write('writing data\n')
  const output = fs.createWriteStream('search/search-index.json')
  output.write(JSON.stringify(result))
  output.close()
})
