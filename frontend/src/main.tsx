import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import App from './App'
import { IntegrationProvider } from './context/IntegrationContext'
import { NotificationProvider } from './context/NotificationContext'
import ToastContainer from './components/ToastContainer'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <BrowserRouter>
      <NotificationProvider>
        <IntegrationProvider>
          <App />
          <ToastContainer />
        </IntegrationProvider>
      </NotificationProvider>
    </BrowserRouter>
  </React.StrictMode>
)
