require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mcrypt < AbstractPhp71Extension
  init
  desc "Interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  revision 13

  bottle do
    sha256 "b5d364dbe37a588576bdeacc87d880288e00e97d6c79031cb14673ff3bf54761" => :sierra
    sha256 "cdbd455b12102ebf55b0048336cc02e94aae748324492ad4b4261fe70e9fc07c" => :el_capitan
    sha256 "614bb7480fa9803021a5f16ed000f0764e50f68090dc0c3bb176708ad7dbdb28" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"
  depends_on "libtool" => :run

  def install
    Dir.chdir "ext/mcrypt"

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
