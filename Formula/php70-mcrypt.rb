require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 8

  bottle do
    sha256 "5fac453b4083c80be050fab54e706d9f693b90f159ff1823dd9a5e7f4e558b81" => :sierra
    sha256 "c6eaf88d45595e95cb5a0f6fb3afb8580313cbc7ced6a7425a7d93d453cb1c9f" => :el_capitan
    sha256 "c3d61f92e68e39e430addda7685628db793e04735c4aaf701523adf3f9a025d9" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
