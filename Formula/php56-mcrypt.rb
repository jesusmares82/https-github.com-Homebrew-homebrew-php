require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mcrypt < AbstractPhp56Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

  bottle do
    sha256 "fc8bbf14f03b23bf3962d2c8cfdab625f6c6fdc51f9ddd14681b980a519f91ee" => :sierra
    sha256 "db66e9104451f5dd90a0fe366d05d5b4ca57c40bf50e2b262b9227fe6255fbd3" => :el_capitan
    sha256 "6fdda3896f73e1423b46b51f8f60bd746be647c3345a74508dd3acec5c4c780f" => :yosemite
  end

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
