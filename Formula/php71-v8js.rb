require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-1.4.1.tgz"
  sha256 "38a16ae4381eb36695cb2f4cce802124242c279cfbd7640d256aff57d260ad4c"

  bottle do
    cellar :any
    sha256 "707213ca377af7b2130c8c229ba554664e82e83fe2f96771872ca408dde0e12e" => :sierra
    sha256 "7cb629db5e78810a478844030c76ad0bab92cad7fa2eb43aa9f302440f1265f8" => :el_capitan
    sha256 "13ffe578d85f6346c20763abdeb9b4232766727053846b8e813c8c597c4673c2" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
