public with sharing class ViaCepGateway {
    ViaCepMapper mapper;
    String endpoint;
    Http http;

    public ViaCepGateway(ViaCepMapper mapper, string endpoint) {
        this.mapper = mapper;
        this.endpoint = endpoint;
        this.http = new Http();
    }

    public BrazillianAddress getAddress(string cep) {
        if (String.isEmpty(cep)) {
            throw new IllegalArgumentException('CEP não pode estar vazio');
        }

        HttpRequest request = new HttpRequest();
        String formattedEndpoint = String.format(this.endpoint, new List<String>{cep});
        request.setEndpoint(formattedEndpoint);
        request.setMethod('GET');

        HttpResponse response;
        try {
            response = http.send(request);
        } catch (CalloutException e) {
            // TODO Handle this error before rethrowing
            throw e;
        } 
        
        Integer status = response.getStatusCode();
        String body = response.getBody();

        if(status >= 400 && status < 500) {
            throw new BadRequestException('Este CEP está mal formatado');
        }

        if(status >= 500 && status < 600) {
            throw new ViaCepServerException('O servidor ViaCep retornou um erro interno');
        }

        if(body.contains('"erro": true')) {
            throw new NonExistentCepException('Este CEP não existe');
        }

        BrazillianAddress address = this.mapper.fromJson(body);            
        return address; 


    }
}
