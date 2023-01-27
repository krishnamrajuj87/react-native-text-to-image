# react-native-text-to-image

This is a fork of the public repository react-native-text-to-image. The fork aims to more permanently implement a solution whereby the images are not stored on the device, but rather just used as base64 image data. This solution is needed in our POS devices to print reciepts as images.

## Getting started

`$ yarn add react-native-text-to-image`

### Mostly automatic installation

`$ react-native link react-native-text-to-image`

## Usage

```javascript
import TextToImage from 'react-native-text-to-image';

TextToImage.convert(text, fontName, fontSize, color, destinationUri => {
    // use image uri here.
});
```
