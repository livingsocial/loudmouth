# Loudmouth

Loudmouth makes JavaScript errors and alerts more obvious in both development and production. You can report errors either immediately using ALERTs (good for dev mode) or by sending the error information back to your server (via an IMG tag).

## How It Works

Loudmouth wraps the <code>onError</code> handler. When an error occurs, it reports the error (see Loud and Silent mode). In Silent mode it also rethrows the error.

# Using Loudmouth

Loudmouth can either report errors loudly (via an immediate alert dialog), or silently (by sending the information back to your server). You can only use one mode at a time.

## Loud Mode

Errors are immediately reported using an ALERT dialog. Errors are not rethrown.

    Loudmouth.watch();

## Silent Mode

Errors are silently captured and then rethrown. Errors are only reported if you set the target url via the <code>hollaback_url()</code> function.

    Loudmouth.hollaback_url('<your URL goes here>');
    Loudmouth.lurk();

Errors are sent by adding an image tag to the DOM. The error details are in the `error_info` parameter as JSON data. The `type` parameter indicates if the data is for an error or an alert.

    GET "/loudmouth/shout?error_info={"errorMessage" : "Uncaught ReferenceError", "lineNumber" : "123", "type" : "error", "href" : "http://my.server.com/fake-error"

The error information contains all of the details reported by JavaScript. The `window.location.href` value is also sent (as the `href` parameter).

## Turning Off Loudmouth

You can turn off silent/loud mode by calling <code>goAway()</code>. This just unwraps the <code>onError</code> handler.

    Loudmouth.goAway();

## LICENSE:

The MIT License

Copyright (C) 2012 LivingSocial

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.