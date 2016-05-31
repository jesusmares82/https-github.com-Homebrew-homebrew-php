require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://github.com/phpv8/v8js/archive/1.3.0.tar.gz"
  sha256 "77df2ca77df53da911c36089185433c73429ef3baf376b6cd5d61bf88202e798"

  bottle do
    cellar :any
    sha256 "59fe312e69d50a95dc3c7e30b9a92cbdd9e5b78a4f9a1f6aada54df1da9f0cfe" => :el_capitan
    sha256 "2306e9de7113990b1b6a90a8be355a1344070f6e5a624653cabdcee05cc8dc0d" => :yosemite
    sha256 "12c4b61f1f33c0eb695aaf4448cba1c1e0db75127e30461e86267f9331307e34" => :mavericks
  end

  depends_on "v8"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
