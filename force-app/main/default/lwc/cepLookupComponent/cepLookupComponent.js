import searchAddress from '@salesforce/apex/CepLookupController.searchAddress';
import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class CepLookupComponent extends LightningElement {
    @api recordId;
    @api objectApiName;
        
    address = {};
    lookupCep = '';
    errorMessage = '';
    loading = false;
    

    get showForm() {
        return !this.loading && !this.errorMessage;
    }

    get showError() {
        return !this.loading && !!this.errorMessage;
    }

    handleLookupCepChange(e) {
        this.lookupCep = e.target.value;
    }

    handleSearch() {
        this.loading = true;
        searchAddress({lookupCep: this.lookupCep})
            .then((result) => {
                const blankFields = { numero: '', complemento: '' }
                Object.assign(this.address, resetFields, result);
                this.errorMessage = '';
            })
            .catch((e) => {
                this.errorMessage = e.body.message;
            })
            .finally(() => {
                this.loading = false;
            });
    }

    handleSuccess(e) {
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(new ShowToastEvent({variant: 'success', title: 'Sucesso', message: 'Endereço Atualizado'}))
    }

    handleError(e) {
        console.log(e.detail.detail);
    }
}