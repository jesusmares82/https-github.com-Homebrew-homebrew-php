require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Hprose < AbstractPhp53Extension
  init
  desc "Hprose for PHP."
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "edc59212e3bc991349ca4b5a88a9da12682459d3bd83816d3917853282351f4d" => :el_capitan
    sha256 "a5b56840614d71881ea705128a3974209d4aca3b7d14f3c72f3fbd6c0af1dd68" => :yosemite
    sha256 "2594a5f2d10a41825c9994b4bf042b42602e9accb76652ec7990ddf4120c1a34" => :mavericks
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
