import bonjour from 'bonjour';

const setupMDns = (port: number) => { // Añadido tipo :number
  const b = bonjour();
  b.publish({ 
    name: 'ExclusiveFinancesHost', 
    type: 'exclusive-finances', 
    protocol: 'tcp', 
    port: port 
  });
  console.log('[mDNS] Servicio anunciado en la red local.');
};

export default setupMDns;