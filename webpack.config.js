const path = require('path')

module.exports = {
  entry: './javascript/src/index.ts',
  mode: 'production',
  module: {
    rules: [
      {
        rules: [
          {
            test: /\.tsx?$/,
            use: 'ts-loader',
            exclude: /node_modules/,
          },
        ],
      }
    ]
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  output: {
    filename: 'compiled.js',
    path: path.resolve(__dirname, 'javascript'),
  },
}
