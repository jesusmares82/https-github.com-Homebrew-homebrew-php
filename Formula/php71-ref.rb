require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ref < AbstractPhp71Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.4.1.tar.gz"
  sha256 "9110b3636d5bd82a48c9e622d1dd2e78f35abff907bcb0cfdfca97bf6d3e212b"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cca27e2dc10a14f2a09759a50aaa0df010ec7517f95c9ef52bcd4ddbe675e4d2" => :el_capitan
    sha256 "ee01f8855875df67f9d641d855a2f301c1ef221481870eaa7369150a59e78c3b" => :yosemite
    sha256 "29ce63f43594b6e341f7faff2fbd5739245d1f2f6c49cdf4aa016b08b0c6e47c" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
