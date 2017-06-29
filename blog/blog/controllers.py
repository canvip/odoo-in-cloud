# -*- coding: utf-8 -*-
from openerp import http

# class Blog(http.Controller):
#     @http.route('/blog/blog/', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/blog/blog/objects/', auth='public')
#     def list(self, **kw):
#         return http.request.render('blog.listing', {
#             'root': '/blog/blog',
#             'objects': http.request.env['blog.blog'].search([]),
#         })

#     @http.route('/blog/blog/objects/<model("blog.blog"):obj>/', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('blog.object', {
#             'object': obj
#         })