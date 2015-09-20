require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Sundown < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/sundown'
  url 'https://pecl.php.net/get/sundown-0.3.11.tgz'
  sha256 '0a143a268f43f5f2a07988116acfa62671fad4636b84c0750327042f9cb8004f'

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file if build.with? "config-file"
  end
end
