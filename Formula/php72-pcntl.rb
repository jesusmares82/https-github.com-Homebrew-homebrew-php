require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Pcntl < AbstractPhp72Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "7e4652275fac735fe1e119b3e454a27fda503bd0cade78f56482e111463ad49a" => :sierra
    sha256 "e290a1220454e6f281700b1c17fa87f397b4ff53a2e3c49fc079194f22599beb" => :el_capitan
    sha256 "2fc6650e0f00aa65350f88efd77bd2425d6f759e971ad8e5e5653b9de2e3f069" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
