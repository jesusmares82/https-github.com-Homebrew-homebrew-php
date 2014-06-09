require File.join(File.dirname(__FILE__), 'abstract-php')

class Php52 < AbstractPhp
  init
  url 'http://museum.php.net/php5/php-5.2.17.tar.bz2'
  sha1 'd68f3b09f766990d815a3c4c63c157db8dab8095'

  head 'https://github.com/php/php-src.git', :branch => 'PHP-5.2'

  depends_on 'mhash'
  depends_on 'libevent' if build.with? 'fpm'

  if build.with? 'phpdbg'
    raise "phpdbg is not supported for this version of PHP"
  end

  def php_version
    5.2
  end

  def php_version_path
    52
  end

  def patches
    'http://php-fpm.org/downloads/php-5.2.17-fpm-0.5.14.diff.gz'
  end

  def install
    super

    if File.exist?(bin + 'php.dSYM')
      mv bin + 'php.dSYM', bin + 'php'
    end

    if File.exist?(bin + 'php-cgi.dSYM')
      mv bin + 'php-cgi.dSYM', bin + 'php-cgi'
    end
  end

  def install_args
    defaults = super
    defaults.delete '--with-mhash'

    if build.with?('mysql') || build.with?('mariadb')
      defaults.delete '--with-mysqli=mysqlnd'
      defaults.delete '--with-mysql=mysqlnd'
      defaults.delete '--with-pdo-mysql=mysqlnd'

      defaults << "--with-mysqli=#{Formula['mysql'].opt_prefix}/bin/mysql_config"
      defaults << "--with-mysql=#{Formula['mysql'].opt_prefix}/bin/mysql_config"
      defaults << "--with-pdo-mysql=#{Formula['mysql'].opt_prefix}/bin/mysql_config"
    end

    defaults + [
      '--enable-zend-multibyte',
      '--enable-sqlite-utf8',
      "--with-mhash=#{Formula['mhash'].opt_prefix}"
    ]
  end

  def default_config
    './php.ini-recommended'
  end

  def skip_pear_config_set?
    true
  end
end
