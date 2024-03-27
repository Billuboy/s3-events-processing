/* eslint-disable import/prefer-default-export */
import { S3Client, GetObjectCommand, PutObjectCommand } from '@aws-sdk/client-s3';

import type { S3Handler } from 'aws-lambda';

import { streamToBuffer, webpConverter } from '@utils';

const s3 = new S3Client();

export const handler: S3Handler = async (event) => {
  if (event.Records[0]) {
    const bucket = event.Records[0].s3.bucket.name;
    const key = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, ' '));
    console.info(`Image to convert: ${key}`);

    const acceptedFormats = new Set(['jpeg', 'png', 'jpg', 'heic']);
    const imageFormat = key.match(/[^.]*$/);

    if (!imageFormat || !acceptedFormats.has(imageFormat[0])) {
      console.error('Image format not allowed');
      return;
    }

    const params = { Bucket: bucket, Key: key };

    try {
      const webpKey = key.replace(/[^.]*$/, 'webp');

      const object = await s3.send(new GetObjectCommand(params));
      const body = await streamToBuffer(object.Body as any);
      const webp = await webpConverter(body);

      await s3.send(
        new PutObjectCommand({
          Bucket: bucket,
          Key: webpKey,
          Body: webp,
          ContentType: 'image/webp',
        }),
      );
      console.info(`Image converted to webp: ${webpKey}`);
    } catch (err) {
      console.error(err);
      throw new Error('Error occurred while processing the file');
    }
  }
};
