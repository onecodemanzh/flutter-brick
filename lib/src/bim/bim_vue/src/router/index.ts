import { createRouter, createWebHistory } from 'vue-router'
import BIM from '../components/bim';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: BIM
    },
  ]
})

export default router
