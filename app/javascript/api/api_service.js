class ApiService {
  async fetchData(url, options = {}) {
    const response = await fetch(url, options);
    return response.text();
  }

  async get(url, headers = {}) {
    const options = { headers: { ...headers, Accept: 'text/plain' } };
    return this.fetchData(url, options);
  }
}

const apiService = new ApiService();
export default apiService;
