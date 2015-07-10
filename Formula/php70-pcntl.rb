require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "38f7dcc1772c8c83d26fa87533a6a0e18aa514b98954c39a23f2547ed27da9b9" => :yosemite
    sha256 "6dc8415da1056c2749e0888a3104590b6c0ec3bdfeb218826aa1faba5a7ada93" => :mavericks
    sha256 "8b9ac888652e7638c8e2563f44fd526e655e21beeef28719eef598479bce2e4e" => :mountain_lion
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
