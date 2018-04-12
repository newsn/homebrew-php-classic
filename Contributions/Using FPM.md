This is a step-by-step guide to set up PHP-FPM to work with Apache. The following assumes that you are familiar with configuring Apache and you know what PHP-FPM is.
In short, PHP-FPM allows you to decouple PHP and your web server, by running PHP instances in separate processes. This has several benefits, including improved performance, robustness (bugs in PHP do not crash the whole web server) and flexibility (e.g., interfacing with Apache and Nginx).
Another advantage, especially for local development, is that PHP may run as your user (which is the default for a “standard” Homebrew), so that files written by web applications will be owned by you, and not by `_www`. See http://php-fpm.org/ and http://php.net/manual/en/book.fpm.php for more information.

## Quick summary

1. `brew install httpd`
2. `brew tap homebrew/homebrew-php` # See caveats
3. `brew install php70` # See caveats
4. Edit Apache main conf file: `$(brew --prefix)/etc/httpd/httpd.conf`
    a. Uncomment: `LoadModule proxy_module  lib/httpd/modules/mod_proxy.so`
    b. Uncomment: `LoadModule proxy_fcgi_module  lib/httpd/modules/mod_proxy_fcgi.so`
    c. Uncomment: `LoadModule vhost_alias_module  lib/httpd/modules/mod_vhost_alias.so`
    d. Uncomment: `Include /usr/local/etc/httpd/extra/httpd-vhosts.conf`

Now you can use `brew services` to start Apache and PHP-FPM. **NB**: If you want to listen on port 80 and 443, then you need to start Apache with `sudo`. Example: `sudo brew services restart httpd && brew services restart php70`

If you are using different versions of PHP, just replace all occurrences of `php70` accordingly in the instructions above.

## Configuring Apache

No other special configuration is needed in Apache, as it works out of the box. But for serious work, you will almost certainly need name-based virtual hosts. This section explains how to enable (SSL) name-based virtual hosts: feel free to skip it if your web server already supports them or you do not bother to enable that feature.

### Name-based virtual hosts

1. Edit `$(brew --prefix)/etc/httpd/extra/httpd-vhosts.conf`
2. Add a directive similar to the following: `Include /usr/local/etc/httpd/vhosts/*.conf`
The above will be the directory where virtual host configuration files will go. The path is arbitrary, but it must exist. In this example, all virtual hosts configuration files are assumed to be in `/usr/local/etc/httpd/vhosts/`.
3. Save `http-vhosts.conf` and test that the configuration is fine by executing `apachectl configtest`.

## Configuring PHP-FPM

PHP-FPM's configuration file is located at `$(brew --prefix)/etc/php/7.0/php-fpm.conf`. The default configuration is fine for most purposes, but you may want to edit it to suit your needs. For example, some parameters you may want to tune are `pm.start_servers` (number of child processes at startup), `pm.max_spare_servers` (maximum number of idle server processes), `pm.max_requests` (maximum number of requests each child process should execute before respawning), etc…

If you want PHP-FPM to listen on a Unix socket instead of a TCP socket (see the virtual host configuration below), which is faster when the web server and PHP-FPM are on the same machine, you must change `listen = 127.0.0.1:9000` to `listen = /tmp/php-fpm.sock` in php-fpm.conf.

More importantly, you can change the pool configuration file `$(brew --prefix)/etc/php/7.0/php-fpm.d/www.conf` and replace the values for `user` and `group` to your user name and "staff" as group. This will avoid permission and ownership of files in your document root.

## Testing PHP-FPM with Apache

You may check that PHP-FPM is configured correctly by running the following:

```
php-fpm -y $(brew --prefix)/etc/php/7.0/php-fpm.conf -t
```

You are now ready to make your first virtual host using PHP-FPM! Create an Apache virtual host configuration file in `/usr/local/etc/httpd/vhosts` (or wherever your virtual host configuration files should be located), whose content will be similar to the following:

```
LogFormat "%V %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combinedmassvhost
<VirtualHost *:8080>
    ServerName dev
    ServerAlias *.dev
    VirtualDocumentRoot /Users/<your_username>/Sites/%-2+

    DirectoryIndex index.php index.html index.htm

	<Directory "/Users/<your_username>/Sites">
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Require all granted
	</Directory>

	<FilesMatch \.php$>
		SetHandler proxy:fcgi://localhost:9000
	</FilesMatch>

    CustomLog "/Users/<your_username>/Sites/logs/dev-access_log" combinedmassvhost
    ErrorLog "/Users/<your_username>/Sites/logs/dev-error_log"
</VirtualHost>
```

The above assumes that virtual hosts are inside directories under `/Users/<your_username>/Sites` (where <your_username> is your actual username on disk). Change this path according to your needs. Also change the port 8080 if for example you decide to listen on port 80.

Now you can create a `website` folder in your Sites folder and throw some PHP script in it. A file called `info.php` with the following content will do:

```php
<?php phpinfo() ?>
```

Do not forget to add the virtual host to `/etc/hosts`. Edit `/etc/hosts` and add the following line:

```
127.0.0.1   website.dev
```

Unless you already started php-fpm with brew services, you can start php-fpm directly from the command line (for debugging):

```
php-fpm --fpm-config $(brew --prefix)/etc/php/7.0/php-fpm.conf
```

Now restart Apache to enable the virtual host. Keep an eye on the Apache error log through the Console app to ensure that there are no errors. Then visit http://website.dev/info.php. If all is fine, you should see a page of information about PHP. In the “Server API” field, you should read “FPM/FastCGI”.

If all is fine, you may kill php-fpm and launch it with brew services. Since PHP and Apache are now decoupled, you may `start`/`stop`/`restart` the web server and PHP independently.

```
brew services start httpd && brew services start php70
```
