import sharp from 'sharp';

export default (body: Buffer) =>
  sharp(body)
    .rotate()
    .resize(120, 120, { fit: 'cover' })
    .toFormat('webp', { quality: 100 })
    .toBuffer();
