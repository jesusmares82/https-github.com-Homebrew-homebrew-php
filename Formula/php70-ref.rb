require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ref < AbstractPhp70Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.4.1.tar.gz"
  sha256 "9110b3636d5bd82a48c9e622d1dd2e78f35abff907bcb0cfdfca97bf6d3e212b"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dee468c8efd8461c829ca628e4d17b568cb5f9c8204e6af0628910b587a3caf8" => :el_capitan
    sha256 "e6abfa32e8c22d8ae3e69218c40aa08919bce8b904f1f7ff10499313f5ebad0e" => :yosemite
    sha256 "7ffa9b784ea865924cfe577133ad00a3dfaf0d40cdbae2e13ef68ca1f19b115a" => :mavericks
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
