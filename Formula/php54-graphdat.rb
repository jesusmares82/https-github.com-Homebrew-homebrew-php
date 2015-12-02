require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Graphdat < AbstractPhp54Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4de2de301456967dbcde16878df7a2d33bed4a7a156fe0728ecd248e003733d9" => :el_capitan
    sha256 "33f2efdd0dec446e47fa72a7072ba0d963baefb47b1bfc7517735473efa8280f" => :yosemite
    sha256 "057f425fc509144ba12cc69a9fde8ee399f36015abc5e360ad94574f021bb853" => :mavericks
  end

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file if build.with? "config-file"
  end
end
