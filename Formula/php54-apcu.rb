require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apcu < AbstractPhp54Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.8.tgz"
  sha256 "bef4f5ae309526a332e0f6b98f0579a45d6000b928991babe684d4c22432d57d"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2e1a947a855656210a51541177101686ee8b922feac4f58d3fc4178d4998c985" => :el_capitan
    sha256 "6baae012ca6d66c47c9548106e3e0adc13bfd5e0ee27e4c764fcc584ce30185a" => :yosemite
    sha256 "139200dd9becd8ef0b074d0acbf85742d7bebc60b11c1b2db0c7c9e2c52af2e7" => :mavericks
  end

  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre"

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.with? "apc-bc"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
