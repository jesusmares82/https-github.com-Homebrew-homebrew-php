require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ref < AbstractPhp70Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.4.4.tar.gz"
  sha256 "51da1e0625e2c89da05bdef5166e1046f5594870df4b0f6925eaa01b69925a9b"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "26806eeed32c18948f657cb8c62ccdf8763fa5a06c756372a1a894316ce7746a" => :sierra
    sha256 "66975f5070a729a85b008ceaf5626a0bddb375ec51cf5589b6e3f96707570891" => :el_capitan
    sha256 "d4bae05aafb9eacdc19bc6f9b6ffdbb459b4fa24a6f66cf2357453d099d6a949" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end

  def caveats
    <<-EOT.undent
      This installs the older php-ref version #{version} which is no longer
      supported because PHP 7.0 support in php-ref discontinued.
    EOT
  end
end
