require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Apcu < AbstractPhp70Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-5.1.0.tgz"
  sha256 "51c285a29c544e50cce6ceec83ba9482e46650ac9e87df7e24704c5c6484449a"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "277d87ddaeba1f1ba96ab41f7c16995631afa1bb76b0b6b542d0039928c76db8" => :el_capitan
    sha256 "196680f7c1f1971d77edf9a3e38c5c6d8296662cf20a1b2e644c4cd13f9bdfa7" => :yosemite
    sha256 "7fd753b69b228d3b11b868cfdcf15931725e1f96ef42ed5bd9c5f1ad68132abb" => :mavericks
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
