const path                    = require('path');
const glob                    = require('glob');
const webpack                 = require('webpack');
const MiniCssExtractPlugin    = require('mini-css-extract-plugin');
const TerserPlugin            = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin       = require('copy-webpack-plugin');
const { CleanWebpackPlugin }  = require('clean-webpack-plugin');

module.exports = (env, options) => ({
  optimization: {
    minimizer: [
      new TerserPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
    './js/app.js': glob.sync('./vendor/**/*.js').concat(['./js/app.js'])
  },
  resolve: {
    extensions: ['.js', '.jsx']
  },
  output: {
    filename: 'app.js',
    path: path.resolve(__dirname, '../priv/static/js')
  },
  devtool: 'source-map',
  module: {
    rules: [
      {
        test: /\.js?x$/,
        exclude: [/node_modules/, /lib/],
        use: ['babel-loader', {loader: 'eslint-loader', options: {fix: true,}}],
      },
      {
        test: /\.s?css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader']
      },
      {
        test: /\.(png|jpe?g|gif|svg)$/,
        exclude: [/font/, /fonts/],
        loader: 'file-loader',
        options: {
          name: '../images/[folder]/[name].[ext]',
          publicPath: '../'
        },
      },
      {
        test: /\.(eot|svg|ttf|woff2?|otf)$/,
        exclude: [/img/, '/images/'],
        loader: 'file-loader',
        options: {
          name: '../fonts/[folder]/[name].[ext]',
          publicPath: '../'
        },
      },
      {
        test: require.resolve('jquery'),
        use: [{
          loader: 'expose-loader',
          options: 'jQuery'
        },{
          loader: 'expose-loader',
          options: '$'
        }]
      }
    ]
  },
  plugins: [
    new MiniCssExtractPlugin({ filename: '../css/app.css' }),
    new CopyWebpackPlugin([{ from: 'static/', to: '../' }]),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.$': 'jquery',
      'window.jQuery': 'jquery',
    }),
    new CleanWebpackPlugin()
  ],
  optimization: {
    minimizer: [
      new TerserPlugin({
        cache: true,
        parallel: true,
        sourceMap: true,
        extractComments: false,
        terserOptions: {
          output: {
            comments: false,
          },
        },
      }),
      new OptimizeCSSAssetsPlugin({
        cssProcessorOptions: {preset: ['default', {discardComments: {removeAll: true}}]},
        canPrint: true,
      }),
    ],
  },
  performance: {
    // hints: false,
  },
});
