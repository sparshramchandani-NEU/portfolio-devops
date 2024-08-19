import { Html, Head, Main, NextScript } from 'next/document';

export default function Document() {
  return (
    <Html>
      <Head>
        {/* Favicon */}
        <link rel="icon" href="/logo.png" type="image/png" />
        
        {/* Title */}
        <title>Sparsh Ramchandani</title>
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
