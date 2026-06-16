import 'package:multicast_dns/multicast_dns.dart';

class NetworkDiscoveryService {
  // El nombre debe coincidir exactamente con el que configuraremos en Fastify
  static const String serviceName = '_exclusive-finances._tcp.local';

  Future<String?> discoverHost() async {
    final MDnsClient client = MDnsClient();
    await client.start();

    try {
      await for (final PtrResourceRecord ptr in client.lookup<PtrResourceRecord>(
          ResourceRecordQuery.serverPointer(serviceName))) {
        
        await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
            ResourceRecordQuery.service(ptr.domainName))) {
          
          // Buscamos la dirección IP asociada al Host
          await for (final IPAddressResourceRecord ip in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
            
            client.stop();
            return 'http://${ip.address.address}:${srv.port}';
          }
        }
      }
    } catch (e) {
      print("Error descubriendo host: $e");
    } finally {
      client.stop();
    }
    return null;
  }
}