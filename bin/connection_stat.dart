import 'package:connection_stat/check_vpn_connection.dart';
import 'package:connection_stat/connection_stat.dart' as connection_stat;

void main(List<String> arguments) async {
  if (arguments.contains('-h') ||
      arguments.contains('--help') ||
      arguments.isEmpty) {
    print('''

Welcome :),
U can use these arguments to customize your connection stat.

--countryCode     Shows country code like IR or US
--flag            Shows country flag emoji
--publicIp        Shows your public ip like 192.168.111.197
--regionName      Shows region like Quebec or Kerman
--isp             Shows ISP title
--vpn             Shows a lock emoji if VPN connected
          ''');
  } else {
    String text = await connection_stat.getFullStat(
      countryCode: arguments.contains('--countryCode'),
      flag: arguments.contains('--flag'),
      publicIp: arguments.contains('--publicIp'),
      regionName: arguments.contains('--regionName'),
      isp: arguments.contains('--isp'),
      vpn: arguments.contains('--vpn'),
    );
    print(text);
    if (await CheckVpnConnection.isVpnActive()) {
      print('');
      print('#A5D6A7');
    }
  }
}
