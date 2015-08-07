require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any
    sha256 "b719fe1e1a116e2fe94916d79e77f4e5c09d631fbba80e7ca460dbc858b06eba" => :yosemite
    sha256 "f8e725c3979338ce0fd9dc026e8e19aeaf5afe10a2469c4ca8ef670fb5eee16d" => :mavericks
    sha256 "6e82207cfa86ab961a9d7ab8e8dd8032211d3992821c7da44ff519cabbea0725" => :mountain_lion
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

  test do
    shell_output("php -m").include?("pcntl")
  end
end

