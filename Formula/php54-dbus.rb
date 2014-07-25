require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dbus < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/dbus'
  url 'http://pecl.php.net/get/dbus-0.1.1.tgz'
  sha1 '63fb2be1d97e0f310c42c89c8e8be7f2e98f89f4'
  head 'http://svn.php.net/repository/pecl/dbus/trunk/'

  depends_on 'pkg-config' => :build
  depends_on 'd-bus' => :build

  def install
    Dir.chdir "dbus-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/dbus.so"
    write_config_file if build.with? "config-file"
  end
end
