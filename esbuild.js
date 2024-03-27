/* eslint-disable import/no-self-import */
require('esbuild').build({
  entryPoints: ['src/s3-put-object.ts'],
  bundle: true,
  minify: true,
  target: 'node18',
  platform: 'node',
  external: ['aws-sdk', 'sharp'],
  outdir: 'out',
});
