require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "105f49c39a763be43bcb5ca31bac317a0c3059058b3e6675f748957d661ef4c7" => :yosemite
    sha256 "db9a0099c31876706062699783b3383e9c823426340e4db8f549c04275dc6631" => :mavericks
    sha256 "a9ecdb67b444e363fff48d256fd7a47162c00992ce13ff423c67dd9f3ef6f73c" => :mountain_lion
  end

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
