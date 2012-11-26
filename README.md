loudmouth
=========

Loudmouth makes JavaScript errors and alerts more obvious in both development and production. You can report errors either immediately using ALERTs (good for dev mode) or by sending the error information back to your server (via an IMG tag).

How It Works
------------

Loudmouth wraps the <code>onError</code> handler. It reports the error information and then rethrows the error.

Using Loudmouth
===============

Loudmouth can either report errors loudly (via an immediate alert dialog), or silently (by sending the information back to your server). You can only use one mode at a time.

Loud Mode
---------

Errors are immediately reported using an ALERT dialog. Errors are not rethrown.

    Loudmouth.watch();

Silent Mode
-----------

Errors are silently captured and then rethrown. Errors are only reported if you set the target url via the <code>hollaback_url()</code> function.

    Loudmouth.hollaback_url('<your URL goes here>');
    Loudmouth.lurk();

Turning Off Loudmouth
---------------------

You can turn off silent/loud mode by calling <code>goAway()</code>. This just unwraps the <code>onError</code> handler.

    Loudmouth.goAway();

