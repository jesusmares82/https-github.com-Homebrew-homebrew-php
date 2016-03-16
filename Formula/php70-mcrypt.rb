require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 12
    sha256 "896de9f98c7b1d3a0b05e6f0f0f132f31c0c07a3a136505615e22cd97a13bd09" => :el_capitan
    sha256 "3424191e0f56f21b618bbb6fcda791e987ff986a3e382f08d9c4a469e1ae7cdd" => :yosemite
    sha256 "c490418e2047c17872e4521158d7058fe00819f02fa3b8c6f97997494544f944" => :mavericks
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




