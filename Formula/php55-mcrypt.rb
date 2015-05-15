require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "292dae77a6e5b8f7cdfacab929c2e6f524efd97c114234f6d69ce013956b37f6" => :yosemite
    sha256 "c818532759874b6c3c582955797a6b137f3ad257835bc3f15c28956af88ac6d3" => :mavericks
    sha256 "739de0758a6b86024ecd148b2ba74f151b9d5d5101ececba87c97ef308ae4418" => :mountain_lion
  end

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula['mcrypt'].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end
end
