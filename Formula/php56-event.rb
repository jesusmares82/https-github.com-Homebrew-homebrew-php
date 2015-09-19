require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Event < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/event'
  url 'https://pecl.php.net/get/event-1.10.3.tgz'
  sha256 'f1955c7f470829024e2f816a2a4c5201bbef3c673e49e7d25a24e248011225be'
  head 'https://bitbucket.org/osmanov/pecl-event.git'

  bottle do
    sha256 "3471bd7b9caeb1abef1a1342b83b64ef684b05e0f25d075cce3e426dafd2c1d0" => :yosemite
    sha256 "96208c09fa491fb8089bd496d55c7c13dacbf7d77def31a3f56ebbd29040abe2" => :mavericks
  end

  depends_on 'libevent' => :build

  def install
    Dir.chdir "event-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--with-event"
    args << "--with-event-libevent-dir=#{Formula['libevent'].opt_prefix}"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/event.so"
    write_config_file if build.with? "config-file"
  end
end
