require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 2
    sha256 "e1cc1c2516e16d2388f0b7ad718c3014c59e9ba76ee1ec9fb20a0af8540099fc" => :el_capitan
    sha256 "d53e209e0ef49e776b3a2520dc44a90d62e1f3b30f7b3000e28263bd49085e0f" => :yosemite
    sha256 "f2b67a36333526233bec451f2258550a47f02c40ab2e68aaf6cb2e41a69b57ab" => :mavericks
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

  test do
    shell_output("php -m").include?("pcntl")
  end
end
