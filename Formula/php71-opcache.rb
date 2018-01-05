require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 18

  bottle do
    cellar :any_skip_relocation
    sha256 "46bcd997a7e9ee3a41db2cf3ba53305219912761acdde53040cbd08fb7b34157" => :high_sierra
    sha256 "d734e66d6a6186a4da2c1c1e9f1f908774f3ee1d44d6c3c2a7f0db4d34489ecb" => :sierra
    sha256 "7cae98af9fc59fdce28ecdc5f44476cf20d9c65a7580bbf3431196f67f3f68eb" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
