require 'watir-webdriver'

class ActiontecConfigSaver
  attr_accessor :host
  attr_accessor :user
  attr_accessor :pass
  attr_accessor :domain
  attr_accessor :page

  def initialize
    @b = Watir::Browser.new
    #@b = Watir::Browser.new :chrome

    @host = '192.168.1.1'
    @user = 'admin'
    @pass = 'admin'
    @domain = 'localhost'

    @page = 'Main'
  end

  def click(t)
    #puts "Searching for: " + t.to_s
    @b.link(:text, t).click
  end

  def goto(t_or_re)
    puts "Going to: " + @page + ' > ' + t_or_re.to_s
    if t_or_re.class == Regexp
      @b.link(:href, t_or_re).click
    else
      re = Regexp.new t_or_re
      click(re)
    end
  end

  def saveHtml(n)
    n.gsub!(/[ \/]+/, '_')
    n.gsub!(/\\\^\$/, '')
    f = n + '.html'
    puts "Saving: " + f
    File.open(f, 'w+b').puts(@b.html)
  end

  def save(t)
    goto(t)
    filename = @page
    if t.class == String
      filename += '-' + t
    end
    saveHtml(filename)
  end

  def login
    @page = 'Main'

    url = 'http://' + @host + '/'
    puts "Visiting " + url
    @b.goto(url)

    puts "Logging in"
    if @b.link(:text, /Logout/).exists?
      @b.link(:text, /Logout/).click
    end

    @b.text_field(:name, 'user_name').set(@user)
    re = Regexp.new 'password_.*'
    @b.text_field(:name, re).set(@pass)
    @b.link(:text, 'OK').click
  end

  def logout
    @page = 'Main'

    puts "Logging out"

    goto('Main')
    if @b.link(:text, /Logout/).exists?
      @b.link(:text, /Logout/).click
    end
  end

  def saveMain
    @page = 'Main'

    goto('Main')
    saveHtml('Main')
  end

  def saveWirelessSettings
    @page = 'Wireless Settings'

    goto('Main')
    goto('Wireless\s+Settings')

    save('Wireless Status')
    save('Basic Security Settings')
    save('Advanced Security Settings')

    @page += '-Advanced Security Settings'

    goto('Main')
    goto('Wireless\s+Settings')
    goto('Advanced Security Settings')
    save('SSID Broadcast')

    goto('Main')
    goto('Wireless\s+Settings')
    goto('Advanced Security Settings')
    save('Wireless MAC Authentication')

    goto('Main')
    goto('Wireless\s+Settings')
    goto('Advanced Security Settings')
    save('802.11b/g/n Mode')

    goto('Main')
    goto('Wireless\s+Settings')
    goto('Advanced Security Settings')
    click('Other Advanced Wireless Options')
    click('Yes')
    saveHtml(@page + '-Other Advanced Wireless Options')

    click('WMM Settings')
    saveHtml(@page + '-Other Advanced Wireless Options-Wireless QoS (WMM)')
  end

  def saveMyNetwork
    @page = 'My Network'

    goto('Main')
    goto('My\s+Network')

    save('Network Status')
    save('Network Connections')

    @page += '-Network Connections'
    click('Full Status')
    saveHtml(@page + '-Full Status')
  end

  def saveFirewallSettings
    @page = 'Firewall Settings'

    goto('Main')
    goto('Firewall\s+Settings')
    click('Yes')

    tabs = [
      'General',
      'Access Control',
      'Port Forwarding',
      'DMZ Host',
      'Port Triggering',
      'Remote Administration',
      'Static NAT',
      'Advanced Filtering',
      'Security Log'
    ]

    for tab in tabs
      save(tab)
    end

    @page += '-Security Log'

    goto('Security Log')
    click('Settings')
    saveHtml(@page + '-Settings')

    goto('Main')
    goto('Firewall\s+Settings')
    click('Yes')
    goto('Security Log')
    click('Hazard')
    saveHtml(@page + '-Hazard')
  end

  def saveParentalControl
    @page = 'Parental Control'

    goto('Main')
    goto('Parental\s+Control')

    save('Parental Control')
    save('Rule Summary')
  end

  def _advanced
    goto('Main')
    goto('Advanced')
    click('Yes')
  end

  def saveAdvanced
    @page = 'Advanced'

    tabs = [
      'ARP Table',
      'Users',
      'Quality of Service\(QoS\)',
      'Local Administration',
      'Remote Administration',
      'Dynamic DNS',
      'DNS Server',
      'Network Objects',
      'SIP ALG',
      'MGCP ALG',
      'Port Forwarding Rules',
      'System Settings',
      'Port Configuration',
      'Date and Time',
      'Scheduler Rules',
      'Firmware Upgrade',
      'IPv6',
      'Routing',
      'IP Address Distribution'
    ]

    for tab in tabs
      _advanced
      save(tab)
    end

    _advanced
    goto('Dynamic DNS')
    click(@domain)
    saveHtml(@page + '-Dynamic DNS-' + domain)

    _advanced
    goto('IPv6')
    goto('IPv6 Firewall')
    saveHtml(@page + '-IPv6-IPv6 Firewall-')

    @page += '-IP Address Distribution'

    _advanced
    goto('IP Address Distribution')
    click('Network (Home/Office)')
    saveHtml(@page + '-Network (Home-Office)')

    _advanced
    goto('IP Address Distribution')
    click('Connection List')
    saveHtml(@page + '-Connection List')

    _advanced
    goto('IP Address Distribution')
    click('Access Control')
    saveHtml(@page + '-Access Control')
  end

  def saveAdvancedQoS
    _advanced
    goto('Quality of Service\(QoS\)')

    @page = 'Advanced-Quality of Service(QoS)'

    tabs = [
      'Traffic Priority',
      'Traffic Shaping',
      'DSCP Settings',
      '802.1p Settings',
      'Class Statistics',
      'Class Identifier',
    ]

    for tab in tabs
      save(tab)
    end
  end

  def saveSystemMonitoring
    @page = 'System Monitoring'

    goto('Main')
    goto('System\s+Monitoring')

    save('Router Status')

    goto('Advanced Status')
    click('Yes')

    tabs = [
      'System Logging',
      'Full Status/System wide Monitoring of Connections',
      'Traffic Monitoring',
      'Bandwidth Monitoring'
    ]

    for tab in tabs
      goto('Main')
      goto('System\s+Monitoring')
      goto('Advanced Status')
      click('Yes')
      save(tab)
    end
  end

  def saveNetworkProperties
    @page = 'My Network'

    tabs = [
      'Network \(Home/Office\)',
      'Ethernet/Coax',
      'Broadband Connection \(Ethernet/Coax\)',
      'Wireless Access Point',
      'WAN PPPoE',
    ]

    for tab in tabs
      goto('Main')
      goto('My\s+Network')
      goto('Network Connections')

      save(tab)
      click('Settings')
      saveHtml(tab + '-Settings')
    end
  end

  def run
    login

    saveMain

    saveWirelessSettings

    saveMyNetwork

    saveNetworkProperties

    saveFirewallSettings

    saveParentalControl

    saveAdvanced

    saveAdvancedQoS

    saveSystemMonitoring

    logout
  end
end
