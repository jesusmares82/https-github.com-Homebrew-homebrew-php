require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Tokyotyrant < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/tokyo_tyrant'
  url 'http://pecl.php.net/get/tokyo_tyrant-0.7.0.tgz'
  sha1 'a3ad6dd4aa59cc99a0da05563e7c5f94020975cc'
  head 'https://github.com/mkoppanen/php-tokyo_tyrant.git'

  depends_on 'pkg-config' => :build
  depends_on 'tokyo-tyrant'

  def extension; "tokyo_tyrant"; end

  def install
    Dir.chdir "tokyo_tyrant-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/tokyo_tyrant.so"
    write_config_file if build.with? "config-file"
  end
end
