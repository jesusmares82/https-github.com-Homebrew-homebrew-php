require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 15
    sha256 "31a68ab01085481fe763bb71d9d88317bb9fc09ab834e5cb0d76b829c2274daa" => :el_capitan
    sha256 "747de11fac5fc27f459aea9e64b3f36ada147dde21035090c604b1bb78376470" => :yosemite
    sha256 "1bd7245b1b274d29600ea8609594318ca49aca4216cbb47f414f9de87f3ff135" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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








