require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    revision 10
    sha256 "b62c680d17735eada76816da307e455365f4a0ededd66d783eb50af84671f3ab" => :el_capitan
    sha256 "530e7049c09177dd62280e725872da180b0b1e920fcb673219e89a0af1409f91" => :yosemite
    sha256 "feab21667a1c51ad3b4f1c4ab87524212e3dd0f72ce6df2724d3c97283d30f5a" => :mavericks
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


