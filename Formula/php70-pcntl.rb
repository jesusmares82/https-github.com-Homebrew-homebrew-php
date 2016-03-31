require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "8ac871834d6dad1354c1332552fec29128f5b3603413b7658a9683b5e256d001" => :el_capitan
    sha256 "7c9f98f2469767277e26b231288ddfe5adb9b3c0b02fece73e34fc26fa4560ae" => :yosemite
    sha256 "99387330f7f100a8424ab3d58bdf42d5825d8444e355306c173c87105f74a6c2" => :mavericks
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





