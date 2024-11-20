---
title: "PHP"
description: >
    Notes on PHP
---

* [PHP 8.2 Manual](https://www.php.net/manual/en/)
* [Packagist - PHP Package Repository](https://packagist.org/)
* [PHP, the right way](https://phptherightway.com/)
* [PHP, framework interop group](https://www.php-fig.org/psr/)

## PHP Upgrades

1. List and store the list of PHP extensions

The following command lists all PHP-related packages that exist on the current system, 
and saves them to a text file named packages.txt. This helps to reconstruct the same list 
of packages on PHP 8.1.

```bash
dpkg -l | grep php | tee packages.txt
```

2. Install PHP 8.1 (or whichever version) and extensions

All PHP 8.1 packages available in the repository added in step #2 follow `php8.1-` naming pattern. 

```bash
sudo apt install php8.1
```

The php8.1-common package includes several common PHP packages. It is possible to selectively 
disable unnecessary extensions later.

```bash
sudo apt install php8.1 php8.1-cli php8.1-{curl,bz2,mbstring,intl}
```

Expand the curly braces above to include all extensions necessary on the new system. When upgrading 
an existing PHP setup, the packages.txt file created in step #1 should list all current PHP packages.

```bash
sudo systemctl restart apache2
```

2b. If Nginx, you need to find the application `.conf` file in sites-enabled and update the php fpm 
TCP socket to use the newer version

```bash
/etc/nginx/sites-enabled/default:    fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
/etc/nginx/sites-enabled/default:    fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
```

and check the configuration

```bash
sudo nginx -t
```

3c. Update the PHP 8.1 worker pool configuration

```bash
sudo vim /etc/php/8.1/fpm/pool.d/*
```

test the configuration

```bash
sudo php-fpm8.1 -t
```

reload and enable services

```bash
systemctl reload php8.1-fpm.service
systemctl reload nginx.service
```

Optionally, disable unused services

```bash
systemctl disable --now php8.0-fpm.service
```


3. Install and enable server APIs

Apache web server with PHP-FPM

```bash
sudo apt install php8.2-fpm
sudo a2enconf php8.2-fpm
sudo a2disconf php8.1-fpm   # When upgrading from an older PHP version
sudo service apache2 restart
```

4. Test PHP 8.1 Installation

To test the PHP CLI installation, try running the following commands:

```bash
php -v
php -m
```

The output is expected to show PHP 8.1, along with a list of enabled PHP extensions.

To test the web server integration, try running a PHP file via the web server.

5. Purge old PHP packages

The following commands remove older PHP versions. It is recommended to not remove them until the 
PHP 8.1 installation is verified to be working correctly.

```bash
sudo apt purge php8.1*   # Change "php8.1" with the old PHP version names.
```

This removes configuration files for the packages being removed as well. If you have phpMyAdmin installed,
you may be presented with the following screen.

```txt
Deconfigure database for phpmyadmin with dbconfig-common = YES
Delete the database for phpmyadmin = NO
```

6. Autoclean and Autoremove

After uninstalling packages from Linux, it’s advised to run these two commands.

```bash
sudo apt-get autoclean
sudo apt-get autoremove
```
