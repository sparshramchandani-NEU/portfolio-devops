import { Html, Head, Main, NextScript } from 'next/document';

export default function Document() {
  return (
    <Html>
      <Head>
        {/* Favicon */}
        // <link rel="icon" href="/favicon.ico" />
        {/* Or if using png */}
        <link rel="icon" href="/logo.png" type="image/png" />
        
        {/* Title */}
        <title>Sparsh Ramchandani's Portfolio</title>
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
